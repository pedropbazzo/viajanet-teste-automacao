Before do
    @utils = Utils.new
end

After do |scn|
    file_name = scn.name.gsub(' ', '_').downcase!
    target = "data/screenshots/#{file_name}.png"
    if scn.failed?
      page.save_screenshot(target)
      embed(target, 'image/png', 'Screenshot')
    else
      page.save_screenshot(target)
      embed(target, 'image/png', 'Screenshot')
    end
    page.driver.quit
end

at_exit do
    ReportBuilder.configure do |config|
        config.input_path = 'data/report/report.json'
        config.report_path = 'data/report/test_suites_report'
        config.report_types = [:retry, :html]
        config.report_title = 'Testes ViajaNet'
        config.include_images = true
        config.color = 'blue'
        config.additional_info = {}
      end
      ReportBuilder.build_report  
end