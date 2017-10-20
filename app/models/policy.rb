class Policy
  attr_reader :permission

  def initialize(permission)
    @permission = permission
  end

  # create and update model is not on permission table. Always return false
  def create?
    permission.new
  end

  def update?
    permission.edit
  end

  def index?
    permission.index
  end

  def new?
    permission.new
  end

  def edit?
    permission.edit
  end

  def destroy?
    permission.remove
  end

  def import?
    permission.import
  end
end
