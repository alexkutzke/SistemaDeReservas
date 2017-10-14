class Policy
  attr_reader :user, :permission, :session_id, :record

  def initialize(user, permission)
    @user = user
    @permission = permission
  end

  # create and update model is not on permission table. Always return false
  def create?
    false
  end

  def update?
    false
  end

  def index?
    permission.index
  end

  def new?
    permission.new?
  end

  def edit?
    permission.edit?
  end

  def destroy?
    permission.remove?
  end

  def import?
    permission.import?
  end
end
