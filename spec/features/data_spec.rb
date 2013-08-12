require 'spec_helper'

module DbdDataEngine
  describe "Data" do
    describe "GET /data" do
      context "routing" do
        it "when the engine is mounted under /" do
          dbd_data_engine.data_index_path.should == '/data'
        end
      end

      context "page content" do

        before(:each) do
          visit(dbd_data_engine.data_index_path)
        end

        it "shows the data" do
          expect(page).to have_text('Data')
        end
      end
    end

    describe "GET /data/new" do
      context "routing" do
        it "when the engine is mounted under /" do
          dbd_data_engine.new_data_path.should == '/data/new'
        end
      end

      context "page content" do

        before(:each) do
          visit(dbd_data_engine.new_data_path)
        end

        it "talks about a new resource" do
          expect(page.text).to match(/new resource/i)
        end

        it "has a select box with schema:givenName as option" do
          expect(page).to have_select('predicate', options: ['schema:givenName','schema:familyName'])
        end
      end
    end
  end
end
