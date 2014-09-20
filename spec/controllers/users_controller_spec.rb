require 'rails_helper'

describe UsersController do
  it "update a user" do
    response = put "/users/testuser.json", {name: "testname"}
    response.code.should == 200

    response = get "/users/testuser.json"
    JSON.parse(response).should == {"name" => "testname"}
  end

  it "should fail if user is not json" do
    put "/users/testuser.json", {name: "testname"}
    response.code.should == 400
  end

  it "should fail if user is not valid" do
    put "/users/testuser.json", {}
    response.code.should == 400

    put "/users/testuser.json", {name: ""}
    response.code.should == 400
  end

  it "should return 404 if user is not found" do
    get "/users/nouser.json"
    response.code.should == 404
  end

  it "should can update" do
    response = put "/users/testuser.json", {name: "testname"}
    response.code.should == 200
    response = put "/users/testuser.json", {name: "testname2"}
    response.code.should == 200


    response = get "/users/testuser.json"
    JSON.parse(response).should == {"name" => "testname2"}
  end
end

