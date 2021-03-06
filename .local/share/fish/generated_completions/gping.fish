# gping
# Autogenerated from man page /usr/local/Cellar/inetutils/1.9.4_1/share/man/man1/gping.1
complete -c gping -l address --description 'send ICMP_ADDRESS packets (root only).'
complete -c gping -l echo --description 'send ICMP_ECHO packets (default).'
complete -c gping -l mask --description 'same as --address.'
complete -c gping -l timestamp --description 'send ICMP_TIMESTAMP packets.'
complete -c gping -s t -l type --description 'send TYPE packets P Options valid for all request types:.'
complete -c gping -s c -l count --description 'stop after sending NUMBER packets.'
complete -c gping -s d -l debug --description 'set the SO_DEBUG option.'
complete -c gping -s i -l interval --description 'wait NUMBER seconds between sending each packet.'
complete -c gping -s n -l numeric --description 'do not resolve host addresses.'
complete -c gping -s r -l ignore-routing --description 'send directly to a host on an attached network.'
complete -c gping -l ttl --description 'specify N as time-to-live.'
complete -c gping -s T -l tos --description 'set type of service (TOS) to NUM.'
complete -c gping -s v -l verbose --description 'verbose output.'
complete -c gping -s w -l timeout --description 'stop after N seconds.'
complete -c gping -s W -l linger --description 'number of seconds to wait for response P Options valid for --echo requests:.'
complete -c gping -s f -l flood --description 'flood ping (root only).'
complete -c gping -l ip-timestamp --description 'IP timestamp of type FLAG, which is one of "tsonly" and "tsaddr".'
complete -c gping -s l -l preload --description 'send NUMBER packets as fast as possible before falling into normal mode of be…'
complete -c gping -s p -l pattern --description 'fill ICMP packet with given pattern (hex).'
complete -c gping -s q -l quiet --description 'quiet output.'
complete -c gping -s R -l route --description 'record route.'
complete -c gping -s s -l size --description 'send NUMBER data octets.'
complete -c gping -s '?' -l help --description 'give this help list.'
complete -c gping -l usage --description 'give a short usage message.'
complete -c gping -s V -l version --description 'print program version.'

