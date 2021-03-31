# RH-SSO Openshift Container Patch

1. Copy this repo
2. Replace `patch.zip` with the desired patch (defaults to 7.4.6 no-op patch from `generate-noop-patch.sh`)
3. Update `sso-patch_buildconfig.yaml`:
    - Change dockerStrategy `from` version if required (defaults to RH-SSO 7.4)
    - Change git `uri` to your copy of this repo (defaults to the original)
4. Add, commit, and push your changes to your copy of this repo
5. Run CLI login command. Copy command shown on this page https://openshifthostnamegoeshere/oauth/token/request
6. `oc project projnamegoeshere` to select your project
7. `oc policy add-role-to-user system:image-puller system:serviceaccount:projnamegoeshere:default --namespace=openshift` to allow official image to be pulled into your project
8. `oc create -f sso-patch_imagestream.yaml` to setup output stream for your image
9. `oc create -f sso-patch_buildconfig.yaml` to install patch buildconfig
10. Image should automatically start building, but if not use `oc start-build sso-patch`
11. Wait for image to build, if successful it will be added as `sso-patch:latest`
12. Edit your application's deployment config `image` variable to `sso-patch:latest`
