Capybara.register_driver :headless_chrome do |app|
  browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.args << "--headless"
    opts.args << "--disable-gpu"
    opts.args << "--no-sandbox"
    opts.args << "disable-dev-shm-usage"
  end
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end
