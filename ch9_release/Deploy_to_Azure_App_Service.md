# Hands-on: Deploy to Azure App Service

```
az group create --name demo-shop --location westeurope
```

```
az appservice plan create \
    --resource-group MY_RESOURCE_GROUP \
    --name MY_APP_SERVICE_PLAN \
    --is-linux \
    --sku P1V2
```

```
az webapp create --name demo-shop --plan demo-shop-plan --resource-group demo-shop --runtime "DOTNET|5.0"
```

```
az webapp deployment list-publishing-profiles -g demo-shop -n mka-demo-shop --xml
```

```
az webapp deployment slot create --name mka-demo-shop --resource-group demo-shop --slot Staging
````

```
az webapp deployment slot swap  -g demo-shop -n mka-demo-shop --slot staging --target-slot production
```

url=https://mka-demo-shop-staging.azurewebsites.net/
status=`curl --silent --head $url | head -1 | cut -f 2 -d' '`
if [ "$status" != "200" ]
then
    echo "Wrong HTTP Status. Expected: '200' - Actual: '$status'"
    exit 1
fi

az group delete --resource-group demo-shop --yes