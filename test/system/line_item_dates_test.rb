require "application_system_test_case"

# def nested_dom_id(*args)
#   args.map { |arg| arg.respond_to?(:to_key) ? dom_id(arg) : arg }.join("_")
# end

class LineItemDatesTest < ApplicationSystemTestCase
  # We must include this module to be able to use the
  # `number_to_currency` method in our test
  include ActionView::Helpers::NumberHelper

  setup do
    login_as users(:accountant)

    @quote          = quotes(:first)
    @line_item_date = line_item_dates(:today)

    visit quote_path(@quote)
  end

  test "Creating a new line item date" do
    assert_selector "h1", text: "First quote"

    click_on "New date"
    assert_selector "h1", text: "First quote"
    fill_in "Date", with: Date.current + 1.day

    click_on "Create date"
    assert_text I18n.l(Date.current + 1.day, format: :long)
  end

  test "Updating a line item date" do
    assert_selector "h1", text: "First quote"

    within id: nested_dom_id(@line_item_date, :edit) do
      click_on "Edit"
    end

    assert_selector "h1", text: "First quote"

    fill_in "Date", with: Date.current + 1.day
    click_on "Update date"

    assert_text I18n.l(Date.current + 1.day, format: :long)
  end

  test "Destroying a line item date" do
    assert_text I18n.l(Date.current, format: :long)

    accept_confirm do
      within id: nested_dom_id(@line_item_date, :edit) do
        click_on "Delete"
      end
    end

    assert_no_text I18n.l(Date.current, format: :long)

    assert_text number_to_currency(@quote.total_price)
  end
end
