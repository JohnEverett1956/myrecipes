require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "janice", email: "janice@example.com",
                    password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "john", email: "john@example.com",
                    password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "john1", email: "john1@example.com",
                    password: "password", password_confirmation: "password", admin: true)    
  end
  
  test "reject an invalid edit" do
    sign_in_as(@chef, "password")       
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: { chefname: " ", email: "janice@example.com"}}
    assert_template "chefs/edit"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
  
  test "accept a valid edit" do
    sign_in_as(@chef, "password")       
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: { chefname: "jack", email: "jack@example.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "jack", @chef.chefname
    assert_match "jack@example.com", @chef.email
  end
  
  test "accept edit of another user by admin user" do
    sign_in_as(@admin_user, "password")       
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: { chefname: "jack1", email: "jack1@example.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "jack1", @chef.chefname
    assert_match "jack1@example.com", @chef.email
  end    
  

  test "reject edit od another user by a non-admin user" do
    sign_in_as(@chef2, "password")       
    patch chef_path(@chef), params: { chef: { chefname: "jack2", email: "jack2@example.com"}}
    assert_redirected_to chefs_path  
    assert_not flash.empty?
    @chef.reload 
    assert_match "janice", @chef.chefname
    assert_match "janice@example.com", @chef.email    
  end
end
