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
                case 400:
                    return View("Error400");
                case 401:
                    return View("Error401");
                case 403:
                    return View("Error403");
                case 404:
                    return View("Error404");
                case 405:
                    return View("Error405");
                case 500:
                    return View("Error500");
                case 502:
                    return View("Error502");
                case 503:
                    return View("Error503");
                case 504:
                    return View("Error504");
                case 505:
                    return View("Error505");
                case 507:
                    return View("Error507");
                default:
                    return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
            }
        }
    }
}
