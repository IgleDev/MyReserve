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
    }
}
