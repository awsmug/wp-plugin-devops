<?php

namespace PluginTests;

/**
 * Defines application features from the specific context.
 */
class FeatureContext extends WordpressContext
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
	    parent::__construct();
    }

	/**
	 * @Given I am on my Site
	 */
	public function iAmOnMySite()
	{
		$this->visitPath( "/" );
	}

	/**
	 * @Then I go to the menu Settings
	 */
	public function iGoToTheMenuSettings()
	{
		$this->visitPath( "/wp-admin/settings.php" );
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
