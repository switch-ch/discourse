class StaticController < ApplicationController

  skip_before_filter :check_xhr, :redirect_to_login_if_required

#  def redirect
#    # this makes logut impossible but the /login page wont show up either, 19.8.2013
#    server_array = env["SERVER_NAME"].split(".")
#    group = server_array.shift
#    url = "https://#{server_array.join('.')}/" 
#    redirect_to url
#  end

  def show

    map = {
      "faq" => "faq_url",
      "tos" => "tos_url",
      "privacy" =>  "privacy_policy_url"
    }

    page = params[:id]

    if page == 'login_admin'
      page = 'login'
    end

    if site_setting_key = map[page]
      url = SiteSetting.send(site_setting_key)
      return redirect_to(url) unless url.blank?
    end

    # Don't allow paths like ".." or "/" or anything hacky like that
    page.gsub!(/[^a-z0-9\_\-]/, '')

    file = "static/#{page}.#{I18n.locale}"

    # if we don't have a localized version, try the English one
    if not lookup_context.find_all("#{file}.html").any?
      file = "static/#{page}.en"
    end

    if not lookup_context.find_all("#{file}.html").any?
      file = "static/#{page}"
    end

    if lookup_context.find_all("#{file}.html").any?
      render file, layout: !request.xhr?, formats: [:html]
      return
    end

    raise Discourse::NotFound
  end

  # This method just redirects to a given url.
  # It's used when an ajax login was successful but we want the browser to see
  # a post of a login form so that it offers to remember your password.
  def enter
    params.delete(:username)
    params.delete(:password)

    redirect_to(
      if params[:redirect].blank? || params[:redirect].match(login_path)
        "/"
      else
        params[:redirect]
      end
    )
  end
end
