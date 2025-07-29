class HomeController < ApplicationController
  def index
    @documents = [
        { link: "https://www.example.pt", preview_text: "something", name: "Documents" },
        { link: "https://www.example.pt", name: "Images" }
    ].map(&OpenStruct.method(:new))
  end
end
