require 'spec_helper'

describe 'LibraryWorker' do

  describe "Perform scrape for libraries" do
    let (:data){ {"url: https://www.google.com"}}
    it "Gets a library from a URL and puts all the adventures in that library into the database" do
      library = Library.create(data)
      LibraryWorker.new.perform(library.url)
      #check that adventures were saved. to do this, will you need a different url?
      library.adventures.should_not be_nil
      library.adventures.length.should > 0
    end
  end
end