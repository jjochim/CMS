require 'test_helper'

class CategoryMoviesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category_movie = category_movies(:one)
  end

  test "should get index" do
    get category_movies_url
    assert_response :success
  end

  test "should get new" do
    get new_category_movie_url
    assert_response :success
  end

  test "should create category_movie" do
    assert_difference('CategoryMovie.count') do
      post category_movies_url, params: { category_movie: { category_id: @category_movie.category_id, movie_id: @category_movie.movie_id } }
    end

    assert_redirected_to category_movie_url(CategoryMovie.last)
  end

  test "should show category_movie" do
    get category_movie_url(@category_movie)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_movie_url(@category_movie)
    assert_response :success
  end

  test "should update category_movie" do
    patch category_movie_url(@category_movie), params: { category_movie: { category_id: @category_movie.category_id, movie_id: @category_movie.movie_id } }
    assert_redirected_to category_movie_url(@category_movie)
  end

  test "should destroy category_movie" do
    assert_difference('CategoryMovie.count', -1) do
      delete category_movie_url(@category_movie)
    end

    assert_redirected_to category_movies_url
  end
end
