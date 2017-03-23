s:
	rails s -b 0.0.0.0

t:
	bundle exec rspec

ARG = target
t-target:test_target do
  bundle exec rspec ${ARG}
end
