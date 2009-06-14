#!/bin/env ruby

# register rules

# for every rev...
message_must_match /this pattern/

email :to => "peter@bla.com" do
  body = <<-EOF
    #{commit.author} commited to #{commit.branch}
    #{commit.diff}
  EOF
end

# ...or scoped to a branch (the more specific one counts!)
branch :master do
  message_must_match /a pattern/  # the message must match a pattern, defaults to a failing hook if unmatched
  
  # examples for email notifications. both would do the same
  email :to => "developers@bla.com", :if       => [:merge, :commit] # works for update types
  email :to => "developers@bla.com", :unless   => :tag              # possitive and negative
end

branch :production, :preview do     # multiple branches
  email :to => "releases@bla.com",  :branch => :production, :if => :tag # works for branches (if in a multi branch rule)
  email :to => "qa@bla.com",        :branch => :preview
  email :to => "developers"
  
  message_pattern = /another pattern/
  message_must_match message_pattern do                            # this lets you define what should happen when the rule is not fulfilled
    add_warning "Please format the messages to match 
                 the pattern #{message_pattern}"
  end
end

# if you don't like any magic
commits.each do |commit|
  logger.info "#{commit.author} committed to #{commit.branch} with the following message #{commit.message}"
end

old_revision # => 19asd9afd881f22n1n2jni12oij
new_revieion # => 9jf29jp12fj2jf19n912p9474cb
ref          # => "refs/heads/master"

=begin
  possible error messages would be:
  
  Hook rejected:
    your commit message did not match the following pattern /a pattern/
    
  Hook rejected:
    the branch "preview" cannot be deleted
=end