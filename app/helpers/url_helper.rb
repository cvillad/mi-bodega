module UrlHelper
  def change_subdomain(url, old_subdomain, new_subdomain)
    if old_subdomain == ""
      if new_subdomain == ""
        url.gsub("//#{old_subdomain}","//#{new_subdomain}")
      else
        url.gsub("//#{old_subdomain}","//#{new_subdomain}.")
      end
    else
      if new_subdomain == ""
        url.gsub("//#{old_subdomain}.","//#{new_subdomain}")
      else
        url.gsub("//#{old_subdomain}","//#{new_subdomain}")
      end
    end
  end
end