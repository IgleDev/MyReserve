using Microsoft.AspNetCore.Mvc;
using MyReserve.Models;
using System.Diagnostics;

namespace MyReserve.Controllers {
    public class HomeController : Controller {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger) {
            _logger = logger;
        }

        public IActionResult Index() {
            return View();  // Devolvemos la vista principal de la aplicaión
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error(int codigoError) {
            switch(codigoError) {
                case 404:
                    return View("Error404");
                case 405:
                    return View("Error404");
                default:
                    return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
            }
        }
    }
}
