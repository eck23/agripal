class News{

  
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  News({required this.title,required this.description,required this.url,required this.urlToImage,required this.publishedAt,required this.content});

}

class Articles{
  
    List articles=[];
  
    Articles();

    addArticles(Map<String,dynamic> article){

      this.articles.add(News(title: article["title"]!, description: article["description"]!, url: article["url"]!, urlToImage: article["urlToImage"]!, publishedAt: article["publishedAt"]!, content: article["content"]!));
    }
}

