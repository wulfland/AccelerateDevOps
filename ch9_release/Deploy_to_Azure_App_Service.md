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
