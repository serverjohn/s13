require 'rails_helper'

RSpec.describe "congregations/edit", type: :view do
  before(:each) do
    @congregation = assign(:congregation, Congregation.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit congregation form" do
    render

    assert_select "form[action=?][method=?]", congregation_path(@congregation), "post" do

      assert_select "input#congregation_name[name=?]", "congregation[name]"
    end
  end
end
