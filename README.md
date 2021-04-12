# RH-SSO Openshift Container Patch - appliable for Developer templates only!
## Compatibility -> 7.4.6.GA or latest

1. Clone this patch repository and push it to your git web repository manager e.g. Github, Gitlab etc. 
2. Replace `patch.zip` with the desired patch (defaults to 7.4.6 no-op patch from `generate-noop-patch.sh`).
3. Update `sso-patch_buildconfig.yaml`:
    - Change dockerStrategy `from` version if required (defaults to RH-SSO 7.4)
    - Change git `uri` to your cloned repository (defaults to the original)
4. Add, commit, and push your changes to your copy of this repo.
5. Run CLI login command. Copy command shown on this page `https://{{openshifthostnamegoeshere}}/oauth/token/request`.
    - {{openshifthostnamegoeshere}} => replace it with your Openshift instance hostname
6. `oc project projnamegoeshere` to select your project
7. `oc policy add-role-to-user system:image-puller system:serviceaccount:$(oc project -q):default --namespace=openshift` to allow official image to be pulled into your project
8. `oc create -f sso-patch_imagestream.yaml` to setup output stream for your image
9. `oc create -f sso-patch_buildconfig.yaml` to install patch buildconfig
10. Image should automatically start building, but if not use `oc start-build sso-patch`.
11. Wait for image to build, if successful it will be added as `sso-patch:latest`.
12. Edit your application's deployment config and replace the `name` (triggers section) value with: `sso-patch:latest`, and also change the `lastTriggeredImage` (triggers section) and `image` (containers section) variables to `image-registry.openshift-image-registry.svc:5000/{{projnamegoeshere}}/sso-patch:latest` value.
    - {{projnamegoeshere}} => replace it with your project name
13. Save the deployment config change and reload it. Check the project pods, you will notice that SSO container was restarted.
14. Open the SSO pod terminal and run this commands to check wheater the patch was applied successfully:
    - `/opt/eap/bin/jboss-cli.sh`
    - `connect`
    - `patch history`
