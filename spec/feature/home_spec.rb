require 'rails_helper'

describe 'Homepage', :type => :feature do
  before { visit root_path }

  it 'welcomes' do
    expect(page).to have_content('Hello World')
  end
end
