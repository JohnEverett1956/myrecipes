require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup 
    @recipe = Recipe.new(name: "Vegetble", description: "Great Vegetable Recipe")
  end
  
  test "recipe should be valid" do
    assert @recipe.valid?
  end
  
  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "description should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test "description must be at lease 5 characters" do
    @recipe.description = "a" * 3
    assert_not @recipe.valid?
  end
  
  test "description caannot exceed 500 characters" do
    @recipe.description = "a" * 1000
    assert_not @recipe.valid?
  end
end