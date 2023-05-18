class GiftFactory
  attr_render :gift

  def self.create!(user, factory, attrs = {})
    gift_factory = GiftFactory.new(user, factory)
    gift_factory.create_form_attrs(attrs)
  end

  def initialize(user, factory)
    @user = user
    @factory = factory
  end

  def create_form_attrs(attrs = {})
    gift = @factory.call(attrs)
    gift.date = earliest_free_gift_date
    gift.user = @user
    gift
  end

  private

  def earliest_free_gift_date
    @user.ungifted_dates.first || Contribution::EARLIEST_PULL_DATE
  end
end
