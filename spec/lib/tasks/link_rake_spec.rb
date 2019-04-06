require 'rails_helper'
require 'rake'

describe 'link:get_all_link' do
  before :all do
    Rake.application.rake_require 'tasks/link'
    Rake::Task.define_task(:environment)
  end

  describe "test get all link" do
    let :run_rake_task do
      Rake::Task['link:get_all_link'].reenable
      Rake.application.invoke_task 'link:get_all_link'
    end

    context "test whole task" do
      it "should call each methods once" do
        expect(LinkMethods).to receive(:get_list_from_url).once
        expect(LinkMethods).to receive(:extract_links_from_list).once
        expect(LinkMethods).to receive(:generate_link_from_links).once
        run_rake_task
      end
    end

    
  end

  describe "test get latest link" do

  end
end