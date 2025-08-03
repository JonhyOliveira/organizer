require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "add content blocks" do
    document = Document.new

    assert document.save
  end
end
