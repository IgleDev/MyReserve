using MyReserve.Models.Repository.RepositoryUsuarios;
using MyReserve.Models;
using MyReserve.Models.Repository.RepositoryGrupoPeluquerias;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddSingleton(new Conexion(builder.Configuration.GetConnectionString("MyReserve")));
builder.Services.AddScoped<IFormulario, FormularioRepository>();
builder.Services.AddScoped<IGrupoPeluquerias, GrupoPeluqueriasRepository>();
builder.Services.AddSession();

var app = builder.Build();
app.UseSession();

// Configure the HTTP request pipeline.
if(!app.Environment.IsDevelopment()) {
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}");

app.Run();
