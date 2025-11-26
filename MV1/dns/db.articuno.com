$TTL    604800
@       IN      SOA     ns1.articuno.com. admin.articuno.com. (
                              4         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns1.articuno.com.
@       IN      A       192.168.1.111
ns1      IN      A       192.168.1.102
www     IN      A       192.168.1.111
