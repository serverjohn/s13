require 'rails_helper'

RSpec.describe "congregations/new", type: :view do
  before(:each) do
    assign(:congregation, Congregation.new(
      :name => "MyString"
    ))
  end

  it "renders new congregation form" do
    render

    assert_select "form[action=?][method=?]", congregations_path, "post" do

      assert_select "input#congregation_name[name=?]", "congregation[name]"
    end
  end
end
