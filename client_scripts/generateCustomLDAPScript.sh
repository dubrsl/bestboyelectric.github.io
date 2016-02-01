
# Each line outputs the groovy code needed to set up your LDAP configuration. 
echo import jenkins.model.*
echo import hudson.security.*
echo import org.jenkinsci.plugins.*
echo import hudson.security.FullControlOnceLoggedInAuthorizationStrategy


echo String server = \"$server\" 
echo String rootDN = "''" 
echo String userSearchBase = \"$userSearchBase\" 
echo String userSearch = \"$userSearch\"
echo String groupSearchBase = \"$groupSearchBase\"
echo String managerDN = \"$managerDN\"
echo String managerPassword = \"$managerPassword\"
echo boolean inhibitInferRootDN = true

echo "SecurityRealm ldap_realm = new LDAPSecurityRealm(server, rootDN, userSearchBase, userSearch, groupSearchBase, managerDN, managerPassword, inhibitInferRootDN)"
echo "Jenkins.instance.setSecurityRealm(ldap_realm)"
echo "Jenkins.instance.setAuthorizationStrategy(new FullControlOnceLoggedInAuthorizationStrategy())"
echo "Jenkins.instance.save()" 


echo uc = Jenkins.instance.updateCenter
echo plugin = uc.getPlugin("git")
echo plugin.deploy()

echo pm = Jenkins.instance.pluginManager

echo def deployPlugin(plugin) {
echo   plugin.getNeededDependencies().each { 
echo     deployPlugin(it) 
echo   }
echo }

echo deployPlugin(plugin)
echo print uc.getJobs()
echo Jenkins.instance.doSafeRestart(null)
