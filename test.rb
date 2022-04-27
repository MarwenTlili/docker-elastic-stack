result = ""
message = "GRAVE: Servlet.service() for servlet [DispatcherServlet] in context with path [/ma-gpro-gpao-rest] threw exception"
result = message.scan(/\[[^]]+\]/)
print result[0]
print "\n"


