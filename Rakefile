ROOT = File.dirname(__FILE__)

desc "Publish the blog using the jekyll executable"
task :default do
  system "jekyll"
end

desc "Update the 'published' bit in posts if the post date is today or earlier"
task :update_published do
  require 'rubygems'
  require 'active_support'
  require 'date'
  entries.each do |post|
    date = Date.parse(post.scan(/_posts\/(\d{4}-\d{2}-\d{2})/).flatten.first)
    updated = File.read(post).sub(/^published: (false|true)$/, "published: #{(date <= Date.today).to_s}")
    File.open(post, 'w') {|file| file.write(updated) }
  end
end

desc "work around for crappy-ass pages.github change"
task :doublespace do
  require 'rubygems'
  require 'active_support'
  entries.each do |post|
    sections = File.read(post).split('---')
    lines = sections.pop.split("\n")
    newlines = []
    lines.each do |line|
      newlines << line
      newlines << ''
    end
    sections << newlines.join("\n")
    File.open(post, 'w') {|f| f.write sections.join("---")}
  end
end

desc "Create a new post, pass P='The Title' to name the new entry, pass YET=n to postdate by n days"
task :new do
  require 'rubygems'
  require 'active_support'
  require 'date'
  date     = Date.today
  date     = date + ENV['YET'].to_i if ENV['YET']
  if ENV['P'] # custom title
    postname = ENV['P']
    slug = postname.gsub(/[^a-z0-9\-_\+]+/i, '-').downcase.chomp("-")
    post = "#{ROOT}/_posts/#{date}-#{slug}.textile"
  else # auto-incrementing title
    number   = Dir.glob("#{ROOT}/_posts/#{date}*").size
    postname = "#{date}-#{number}"
    slug     = postname
    post     = "#{ROOT}/_posts/#{postname}.textile"
  end
  File.open(post, 'w') do |f|
    f.write <<-EOS
---
layout: post
title: #{postname}
permalink: #{slug}.html
published: false
author: Jack Danger Canty
---

EOS
  end
  system "mate #{post}"
end

def entries
  Dir.glob("./_posts/*")
end
