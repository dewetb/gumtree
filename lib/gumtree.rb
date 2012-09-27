require 'httpclient'

class Gumtree
  BASE_DOMAIN = "gumtree.co.za"
  AUTH_DOMAIN = "secure.#{BASE_DOMAIN}"
  USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1"

  def initialize(location, username=nil, password=nil)
    @location = location
    @username = username || ENV["GUMTREE_USERNAME"]
    @password = password || ENV["GUMTREE_PASSWORD"]
    @connected = false
    @http_client = HTTPClient.new
    @base_url = "http://#{@location}.#{BASE_DOMAIN}"

    signin_url = "https://#{AUTH_DOMAIN}/#{@location}/s-SignIn"

    # 1. Visit signin url and pick up initial cookies
    @http_client.get(signin_url, nil, { "User-Agent" => USER_AGENT })

    # 2. Post login credentials to signin url
    params = {
      "GreetingName" => @username, "Password" => @password,
      "rup" => "", "ruq" => "", "AdId" => "0", "Mode" => "Normal", "KeepLoggedIn" => "checked", "Submit" => "Sign In"
    }
    auth_response = @http_client.post(signin_url, params, { "User-Agent" => USER_AGENT })
    auth_redirect = auth_response.headers.fetch("Location")
    raise "Unexpected authentication redirect" unless auth_redirect == "https://#{AUTH_DOMAIN}/#{@location}/s-SignInVerify"

    # 3. Follow their verify redirect
    verified_response = @http_client.get(auth_redirect, nil, { "User-Agent" => USER_AGENT })
    verified_redirect = verified_response.headers.fetch("Location")
    raise "Unexpected verification redirect" unless verified_redirect == @base_url

    @connected = true
  end

  def connected?
    @connected
  end

  def post_ad(params)
    # 1. Post it
    post_ad_url = "#{@base_url}/c-PostAd"
    post_response = @http_client.post(post_ad_url, params, { "User-Agent" => USER_AGENT })
    post_redirect = post_response.headers.fetch("Location")

    # Grab AdId from redirect
    if matches = post_redirect.match(/#{@base_url}\/c-ActivateAd\?AdId=(\d+)&Guid=[0-9a-f-]+&InstAct=true/)
      ad_id = matches[1]
    else
      raise "Unexpected post_ad response with 'Location' #{post_redirect}"
    end

    # 2. Follow their activate redirect
    activate_response = @http_client.get(post_redirect, nil, { "User-Agent" => USER_AGENT })
    activate_redirect = activate_response.headers.fetch("Location")
    raise "Unexpected activate redirect" unless activate_redirect.match(/#{@base_url}\/c-ViewAd\?AdId=#{ad_id}.*/)

    # 3. Follow their verify redirect
    view_ad_response = @http_client.get(activate_redirect, nil, { "User-Agent" => USER_AGENT })
    raise "Title not found in ad" unless view_ad_response.body.include?(params["Title"])

    build_ad(ad_id, params)
  end

  def delete_ad(ad_id)
    raise "Not implemented yet."
  end

  def build_ad(id, params={})
    GumtreeAd.new(self, id, params)
  end
end


class GumtreeAd
  attr_reader :id

  def initialize(gumtree, id, params)
    @gumtree = gumtree
    @id = id
    @params = params
  end

  def param(name)
    @params.fetch(name)
  end

  def delete
    @gumtree.delete_ad(id)
  end
end