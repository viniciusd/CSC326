<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Programming Languages - ERROR</title>

<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/pure-min.css">

    <!-- Bootstrap Core CSS -->
    <link href="/static/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/static/css/landing-page.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">


</head>

<body>

    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
                % if user != None:
                <a class="navbar-brand">{{user}}</a>
                % end
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <!-- div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"-->
                <ul class="nav navbar-nav navbar-right">
                % if user is None:			
                <form action="/login/google" class="pure-form">
   				 	<fieldset>
                       <button type="submit" class="pure-button pure-button-primary">Sign in</button>
                    </fieldset>
				</form>
				% else:
                <form action="/logout" class="pure-form">
   				 	<fieldset>
                       <button type="submit" class="pure-button pure-button-primary">Sign Out</button>
                    </fieldset>
				</form>
				%end
                </ul>
            <!--/div-->
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Header -->
    <div class="intro-header">

        <div class="container">

            <div class="row">
                <div class="col-lg-12">
                    <div class="intro-message">
                        <h1>Programming Languages</h1>
                       
                        <hr class="intro-divider">
                        
						<h3>ERROR 404</h3>
                        <form action="/" method="POST">
                       
                       		
  						  	<button type="submit" class="pure-button" value="Submit">Back to Home Page</button>
                            
                        
                        </form>
                        

                    </div>
                </div>
            </div>

        </div>
        <!-- /.container -->


    <!-- jQuery Version 1.11.0 -->
    <script src="js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

</body>

</html>
