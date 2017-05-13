require 'rails_helper'

RSpec.describe "congregations/index", type: :view do
  before(:each) do
    assign(:congregations, [
      Congregation.create!(
        :name => "Name"
      ),
      Congregation.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of congregations" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
