# w00t?
A simple DSL for writing githooks

# why?
Because parsing comandline stuff and diving to manpages should not be neccassary for something that simple as hooks, at least not for the basic and most common features nearly every hook uses.

# how?
This might be a update hook for example in the first step we'll need to do that booring Hook.new() do thingy. Later this will be full of awesomeness and such...

  require 'lib/hooker'

  Hooker::Hook.new(:update, nil) do
    branch :master do                           # this scopes to a branch / ref
      cant_get_deleted
      commit_messages.must_match /some pattern/ # use the commit_messages macro to apply rules to every commit message
      commits { puts message }                  # access every commit that matches this scope
    end

    commits do                                  # this is the same as above but for every commit, not only the scope
      puts message                              # you can access every commit object
      message.must_match /some other pattern/   # you can use some macros (this might add 'warnings' or 'errors')
                                                # or just decline the commit
      email_to("some_email@googlegael.com")     # another macro to email every successfull commit
    end
  end