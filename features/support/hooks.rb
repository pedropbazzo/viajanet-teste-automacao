Before do
    @utils = Utils.new
end

After do |scn|
    scenario = scn.name.gsub(' ', '_').downcase!
    executionTime = Time.new.strftime('%Y-%d-%m %H:%M:%S')
    if scn.failed?
      target = "data/screenshots/FAILED_#{scenario}_#{executionTime}.png"
    else
      target = "data/screenshots/SUCCESS_#{scenario}_#{executionTime}.png"
    end
    page.save_screenshot(target)
    embed(target, 'image/png', 'Screenshot')
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