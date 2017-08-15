<?php

namespace PluginTests;

use Behat\Behat\Tester\Exception\PendingException;
use Behat\Mink\Exception\Exception;
use PaulGibbs\WordpressBehatExtension\Context\RawWordpressContext;
use Behat\Behat\Context\SnippetAcceptingContext;

/**
 * Defines application features from the specific context.
 */
class FeatureContext extends RawWordpressContext implements SnippetAcceptingContext
{
    /**
     * Initializes context.
     *
     * Every scenario gets its own context instance.
     * You can also pass arbitrary arguments to the
     * context constructor through behat.yml.
     */
    public function __construct()
    {
    }

	/**
	 * @Given I am on my Site
	 */
	public function iAmOnMySite()
	{
		$this->visitPath( "/" );

	}
	/**
	 * @Then I see a title named :arg1
	 */
	public function iSeeATitleNamed($arg1)
	{
		$page = $this->getSession()->getPage();
		$node = $page->find('css','.wrap h1' );
		$title = $node->getText();

		if( $title !== $arg1 ) {
			throw new \Exception( "Title is " . $title . " but should be " . $arg1 );
		}
	}
}
