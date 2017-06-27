Imports System.Web.Optimization
Imports System.Data.Entity

Public Class MvcApplication
    Inherits System.Web.HttpApplication

    Sub Application_Start()
        Database.SetInitializer(Of MyCompanyContext)(New MyCompanyInitializer())

        AreaRegistration.RegisterAllAreas()
        FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters)
        RouteConfig.RegisterRoutes(RouteTable.Routes)
        BundleConfig.RegisterBundles(BundleTable.Bundles)
    End Sub
End Class