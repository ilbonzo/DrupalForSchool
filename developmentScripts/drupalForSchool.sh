drush -y pm-enable pathauto
drush -y pm-enable views
drush -y pm-enable views_ui
drush -y pm-enable webform
drush -y pm-enable wysiwyg
drush -y pm-enable Libraries
drush -y pm-enable libraries
drush -y pm-enable date
drush -y pm-enable date_views
drush -y pm-enable date_popup
drush -y pm-enable email
drush -y pm-enable jquery_update
drush -y pm-enable bootstrap
drush -y pm-enable profiler_builder

drush -y vset theme_default bootstrap
drush -y pm-disable bartik

drush cron
drush -y pm-update
drush cc all