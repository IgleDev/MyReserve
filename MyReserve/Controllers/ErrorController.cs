using Microsoft.AspNetCore.Mvc;
using MyReserve.Models.HelpersTablasBBDD.CodigoError;

namespace MyReserve.Controllers {
    public class ErrorController : Controller {

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error(int CodigoError) {
            var errorModel = new CodigoError {  // Creamos la vista
                codigoError = CodigoError
            };

            return View(errorModel);    // La mandamos
        }
    }
}
