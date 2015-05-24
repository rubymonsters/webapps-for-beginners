require "sinatra"

class Member
  attr_reader :name

  def initialize(name = nil)
    @name = name
  end
end

class MemberValidator
  attr_reader :name, :names, :messages

  def initialize(name, names)
    @name = name.to_s
    @names = names
    @messages = []
  end

  def valid?
    validate
    messages.empty?
  end

  private

    def validate
      if name.empty?
        messages << "You need to enter a name"
      elsif names.include?(name)
        messages << "#{name} is already included in our list."
      end
    end
end

FILENAME = "names.txt"

def members
  names.map { |name| Member.new(name) }
end

def names
  return [] unless File.exists?(FILENAME)
  File.read(FILENAME).split("\n")
end

def find_member(name)
  members.detect { |member| member.name == name }
end

def add_member(name)
  File.open(FILENAME, "a+") do |file|
    file.puts(name)
  end
end

def remove_member(name)
  lines = names.reject { |other| name == other }

  File.open(FILENAME, "w+") do |file|
    file.puts(lines.join("\n"))
  end
end

get "/members" do
  @members = members
  erb :index
end

get "/members/new" do
  @member = Member.new
  erb :new
end

post "/members" do
  name = params[:name]
  validator = MemberValidator.new(name, names)

  if validator.valid?
    add_member(name)
    redirect "/members/#{name}"
  else
    @member = Member.new(name)
    @messages = validator.messages
    erb :new
  end
end

get "/members/:name" do
  @member = find_member(params[:name])
  erb :show
end

get "/members/:name/edit" do
  @member = find_member(params[:name])
  erb :edit
end

put "/members/:name" do
  @member = find_member(params[:name])
end

get "/members/:name/delete" do
  @member = find_member(params[:name])
  erb :delete
end

delete "/members/:name" do
  remove_member(params[:name])
  redirect "/members"
end
