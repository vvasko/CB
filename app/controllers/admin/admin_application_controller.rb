class Admin::AdminApplicationController < ApplicationController
  include Admin::SessionsHelper
  layout 'application_admin'
end
