chmod -R 777 /var/www/html
chown -R www-data:www-data /var/www/html

php -d memory_limit=-1  bin/magento maintenance:enable
rm -rf var/cache var/page_cache var/view_preprocessed generated/* pub/static/*
php -d memory_limit=-1 bin/magento cache:disable
php -d memory_limit=-1 bin/magento setup:upgrade
php -d memory_limit=-1 bin/magento setup:di:compile
rm -rf var/view_preprocessed/pub
php -d memory_limit=-1 time bin/magento setup:static-content:deploy -f
php -d memory_limit=-1 bin/magento setup:upgrade --keep-generated
php -d memory_limit=-1 bin/magento indexer:reindex
php -d memory_limit=-1 bin/magento cache:enable
php -d memory_limit=-1 bin/magento cache:clean
php -d memory_limit=-1 bin/magento cache:flush
php -d memory_limit=-1 bin/magento maintenance:disable


sudo chmod -R 777 var/pub/generated/

