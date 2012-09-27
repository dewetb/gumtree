VCR.configure do |c|
  c.cassette_library_dir = "fixtures/vcr_cassettes"
  c.hook_into :webmock
  c.filter_sensitive_data("<GUMTREE USERNAME>", ENV.fetch("GUMTREE_USERNAME"))
  c.filter_sensitive_data("<GUMTREE PASSWORD>", ENV.fetch("GUMTREE_PASSWORD"))
end