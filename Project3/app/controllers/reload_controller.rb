# frozen_string_literal: true

# This controller handles actions relating to reloading the database. It allows the admin to get the empty form where they specify
# filters for reloading the database (if any), and trigger a reload of the database on submission of that form.
class ReloadController < ApplicationController
  before_action :authenticate
  skip_before_action :verify_authenticity_token

  # get a new HTML form for inputting filters on the reload. this will allow the admin to specify which campus and term(s) they
  # would like to reload data in for.
  def new; end

  # This method is called on submission of the "new" form.
  # It uses the term code passed from the "new" form to parse in the specified data from the database.
  def reload_database2
    Course.destroy_all
    Services::Parsing.load('col', params[:termCode])
    redirect_to courses_path
  end

  # This method is called on submission of the "new" form.
  # It uses the params passed from the "new" form to parse in the specified data from the database.
  def reload_database
    # if there are courses in the database already, clear them out
    Course.destroy_all
    # parse the API
    # This is a map of the form parameters to their corresponding URL code for the API
    term_dictionary = { 'All Terms' => '', 'Spring 2023' => '1232', 'Autumn 2023' => '1238', 'Summer 2023' => '1234' }
    # Get the URL code associated with the form parameter for "Term"
    n = tdictionary
    # if "all terms" was chosen, meaning tdictionary returned an empty string, parse in course data for each term available in the API,
    # along with the specified campus
    if n == ''
      Services::Parsing.load(cdictionary, term_dictionary['Spring 2023'])
      Services::Parsing.load(cdictionary, term_dictionary['Autumn 2023'])
      Services::Parsing.load(cdictionary, term_dictionary['Summer 2023'])
    else
      # otherwise, only parse in data for the specified term and the specified campus
      Services::Parsing.load(cdictionary, n) # params from view
    end
    # redirect to the newly populated course catalog
    redirect_to courses_path
  end

  private

  # These helper functions map the values passed in from the reload form to its corresponding parameter used in the API URL.
  def tdictionary
    # Map the term filter passed in from the form to its query code
    term_dictionary = { 'All Terms' => '', 'Spring 2023' => '1232', 'Autumn 2023' => '1238',
                        'Summer 2023' => '1234' }
    term_dictionary[params[:term]]
  end

  def cdictionary
    # Map the campus filter passed in from the form to its query abbreviation
    # In the API, selecting "All Campuses" defaults to parsing in only the Columbus campus, so we implemented it in the same way
    campus_dictionary = { 'All Campuses' => 'col', 'Columbus' => 'col', 'Lima' => 'lma', 'Mansfield' => 'mns',
                          'Marion' => 'MRN', 'Newark' => 'nwk', 'Wooster' => 'WST' }
    campus_dictionary[params[:campus]]
  end

  def authenticate
    redirect_to '/' unless current_user&.role == 'admin'
  end
end
