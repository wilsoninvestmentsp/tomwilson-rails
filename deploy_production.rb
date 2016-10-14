require '/LIBS/gentools'
require 'active_support/all'

JP 'Deploying Production'
sleep 3

system 'ruby config_production.rb'

system 'git checkout production'
system 'git merge master'
system 'git push origin production'
system 'git checkout master'