class WelcomeController < ApplicationController
  def index
    @classrooms = Classroom.where(state: true)
    puts @classrooms.count
    @event = Event.new
  end
end
