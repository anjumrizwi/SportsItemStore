using System;
using System.Web.Mvc;
using SportsItemsStore.WebUI.Models;
using System.Text;

namespace SportsItemsStore.WebUI.HtmlHelpers
{
    public static class PagingHelpers
    {
        public static MvcHtmlString PageLinks(this HtmlHelper html, PagingInfo pagingInfo, Func<int, string> pageUrl)
        {
            var result = new StringBuilder();

            for (var i = 1; i <= pagingInfo.TotalPages; i++)
            {
                var tag = new TagBuilder("a"); // Construct an <a> tag

                //tag.MergeAttribute("href", pageUrl(i, pagingInfo.SizeId));

                tag.MergeAttribute("href", pageUrl(i));


                tag.InnerHtml = i.ToString();
                if (i == pagingInfo.CurrentPage)
                    tag.AddCssClass("selected");

                result.Append(tag);
            }

            return MvcHtmlString.Create(result.ToString());
        }
    }
}