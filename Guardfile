guard :rspec, all_on_start: true, cmd: 'bundle exec rspec' do
  watch(/^spec\/.+_spec\.rb$/)
  watch(/^lib\/(.+)\.rb$/)     { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { 'spec' }
end

guard :rubocop do
  watch('duet.gemspec')
  watch('Rakefile')
  watch(/.+\.rb$/)
  watch(/(?:.+\/)?\.rubocop\.yml$/) { |m| File.dirname(m[0]) }
end
